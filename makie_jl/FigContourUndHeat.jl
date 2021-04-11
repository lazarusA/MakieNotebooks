using CairoMakie # using GLMakie
# modifying the default theme
set_theme!(
    rowgap = 5,
    colgap = 5, 
    fontsize = 16, font =:sans,
    Axis = (
        xgridcolor = :black, 
        ygridcolor = :black, 
        backgroundcolor = :white,
        xgridstyle=:dash, 
        ygridstyle=:dash, 
        xgridwidth=0.15, 
        ygridwidth=0.15, 
        xtickalign=1, 
        ytickalign=1, #xtickcolor = :red, ytickcolor = :white,
        xgridvisible = true, 
        ygridvisible = true),
    Colorbar = (
        topspinevisible = false, 
        rightspinevisible = false,
        bottomspinevisible = false, 
        leftspinevisible = false,
        width = 12, 
        height = Relative(1), 
        tickalign = 1, 
        labelpadding = -5),
    Legend = (
        tellheight = false, 
        tellwidth = false, 
        halign = :left, 
        valign = :bottom, 
        labelsize = 14, 
        linewidth = 2,
        margin = (10, 10, 10, 10), 
        framevisible = true)
)
## the actual plot
function tα_qubit(β, ψ1, ψ2, fα, f)
    2 + 2*β - cos(ψ1) - cos(ψ2) - 2*β*cos(π*fα)*cos(2*π*f + π*fα - ψ1- ψ2)
end
ψ1 = ψ2 = LinRange(0, 4*π, 100)
z = [tα_qubit(.61, x, y, 0.2, .1) for x in ψ1, y in ψ2]

fig = Figure(resolution = (800, 400))
ax1 = Axis(fig, aspect = 1, xlabel = "ψ1", ylabel = "ψ2", xtickalign = 0,  ytickalign = 0)
clines = contour!(ax1, ψ1, ψ2, z, colormap = :plasma, levels = 20, linewidth = 1.5)
limits!(ax1, 0, 4π, 0, 4π)
ax2 = Axis(fig, aspect = 1, xlabel = "ψ1", xtickalign = 0,  ytickalign = 0)
clines = heatmap!(ax2, ψ1, ψ2, z, colormap = :plasma)
limits!(ax2, 0, 4π, 0, 4π)
cbar = Colorbar(fig, clines, label ="α-q", labelpadding = 0, height = Relative(3/4))
fig[1, 1] = ax1
fig[1, 2] = ax2
fig[1, 3] = cbar
hideydecorations!(ax2)
#save("./results/FigContourUndHeat.svg", fig, pt_per_unit = 0.7);
save("FigContourUndHeat.png", fig, px_per_unit = 2)
fig
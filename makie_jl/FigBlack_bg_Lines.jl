# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie

set_theme!(
    rowgap = 5,
    colgap = 5,
    fontsize = 16, 
    backgroundcolor = :black, # "#212946",
    Axis = (
        xgridcolor = :white, 
        ygridcolor = :white, 
        backgroundcolor = :black, # "#212946",
        xgridstyle=:dash, 
        ygridstyle=:dash, 
        xgridwidth=0.35, 
        ygridwidth=0.35, 
        xtickalign=0, 
        ytickalign=0, 
        xtickcolor = :white, 
        ytickcolor = :white,
        bottomspinecolor = :white, 
        topspinecolor =:white,
        leftspinecolor =:white,
        rightspinecolor =:white,
        xlabelcolor=:white, 
        ylabelcolor = :white,
        xticklabelcolor = :white, 
        yticklabelcolor = :white,
        xgridvisible = true, 
        ygridvisible = true),
    Colorbar = (
        topspinevisible = false, 
        rightspinevisible = false,
        bottomspinevisible = false, 
        leftspinevisible = false,
        width = 12, 
        height = Relative(4/4), 
        labelcolor = :white,
        ticklabelcolor = :white,
        tickalign = 1, 
        tickcolor = :white, 
        labelpadding = -5, 
        ticklabelsize = 16),
    Legend = (#titlecolor = :white # not working or missing
        tellheight = false, 
        tellwidth = false, 
        halign = :right, 
        valign = :top, 
        labelsize = 16,
        linewidth = 2,
        markersize = 7, 
        margin = (10, 10, 10, 10),
        framevisible = true, 
        framecolor = (:white, 0.25),
        bgcolor = (:grey, 0.25), 
        labelcolor = :white, 
        titlecolor = :white)
)

ecycl_x(r,k,θ) = r*(k .+ 1).*cos.(θ) .- r*cos.((k .+ 1) .* θ)
ecycl_y(r,k,θ) = r*(k .+ 1).*sin.(θ) .- r*sin.((k .+ 1) .* θ)
θ = LinRange(0,6.2π,1000)

tronLegacy = ["#FF410DFF", "#6EE2FFFF", "#F7C530FF", "#95CC5EFF",
"#D0DFE6FF", "#F79D1EFF", "#748AA6FF"];

fig = Figure(resolution = (470, 400), font = :sans)
ax   = Axis(fig, aspect =1,title = "Epicycloid",  titlecolor = :white, #not working!
    xlabel = "x(θ) = r(k+1)cos(θ) -rcos((k+1)θ)", 
    ylabel ="y(θ) = r(k+1)cos(θ) -rcos((k+1)θ)")
#lines!(ax, ecycl_x(1,1,θ),  ecycl_y(1,1,θ), color = :red)
lins = [lines!(ecycl_x(2k,k,θ), ecycl_y(2k,k,θ), linewidth = 1.5,
        color = tronLegacy[indx]) for (indx,k) in enumerate(2:0.5:5)]
leg = Legend(fig, lins, string.(2:0.5:5), "k , r=2k", tellheight = true, 
        tellwidth = true, nbanks = 1)
fig[1, 1] = ax
fig[1, 2] = leg
save("FigBlack_bg_Lines.png", fig, px_per_unit = 1);
fig
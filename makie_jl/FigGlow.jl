# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors
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

χ0(xs, Ωs) = (Ωs/π)^(1/4) .* exp.(- Ωs*xs.^2.0./2)
χ1(xs, Ωs) = (4Ωs^3/π)^(1/4) .* xs .* exp.(- Ωs*xs.^2.0./2)
function χn(x; m = 2, t0 = 3, ω₀ = 0.57, Eα0 = -0.9)
    nr = m - 1
    T0 = 41.34*t0
    Ωs = T0^2/(4*log(2))
    x₀ = Eα0 .+ 2ω₀
    xs = (x .- x₀)
    a, b = χ1(xs, Ωs), χ0(xs, Ωs)
    if m<0
        return println("m must be greater than zero")
    elseif m==0
        return b
    elseif  m==1
        return a
    else
        for n in 1:nr
            a, b = √(2Ωs/(n+1)) .* xs .* a .-  √(n/(n+1)) .* b, a
        end
    end
    return a
end
cmap = reverse(get(colorschemes[:Spectral_10], LinRange(0,1,25))) # deep
x = LinRange(0,1,1500)

fig = Figure(resolution = (1000, 450), font = :sans)
ax  = Axis(fig, xlabel = "x", ylabel ="χn")
for n in 0:15
    lines!(x, χn(x; m = n, ω₀ = 0.77), color = cmap[n+2])
    #glow effect
    if n<7
        [lines!(x, χn(x; m = n, ω₀ = 0.77), color = (cmap[n+2],0.08),linewidth = 0.8 + 2*i) for i in 1:8-n]
    else
        [lines!(x, χn(x; m = n, ω₀ = 0.77), color = (cmap[n+2],0.08),linewidth = 0.8 + 2*i) for i in 1:5]
    end
end
limits!(ax, 0.52,0.74, -6, 6.8)
fig[1,1]= ax
save("FigGlow.png", fig, px_per_unit = 2)
fig
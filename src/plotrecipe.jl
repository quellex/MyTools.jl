# %%
using Plots
using Measurements
# %%

begin
	cp = palette(:default)
	default(size=(600, 400), foreground_color_legend=nothing, margin=3Plots.mm, linewidth=1.5, legendtitlefontsize=10.0)
	l1b = Dict(:color => :black, :linewidth => 4.0)
	l1 = Dict(:color => :black, :linewidth => 2.0)
	l2 = Dict(:color => cp[1])
	l3 = Dict(:color => cp[2], :linestyle => :dash)
	l4 = Dict(:color => cp[3], :linestyle => :dashdot)
	l5 = Dict(:color => cp[4], :linestyle => :dashdotdot)
end

# %%
function test()
    plot()
    plot!(rand(10);l2...)
    plot!(rand(10);l3...)
    plot!(rand(10);l4...)
    plot!(rand(10);l5...)
    plot!(rand(10);l1...)
end

# %%
# test()

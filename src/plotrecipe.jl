# %%
using Plots
# %%
function test()
    plot()
	plot!(rand(10);l1...)
    plot!(rand(10);l2...)
    plot!(rand(10);l3...)
    plot!(rand(10);l4...)
	plot!(rand(10);l5...)
end
# %%
module MyPlot
export l1b, l1, l2, l3, l4, l5
using Plots
using Measurements
	cp = palette(:default)
	l1b = Dict(:color => :black, :linewidth => 4.0)
	l1 = Dict(:color => :black, :linewidth => 2.0)
	l2 = Dict(:color => cp[1])
	l3 = Dict(:color => cp[2], :linestyle => :dash)
	l4 = Dict(:color => cp[3], :linestyle => :dashdot)
	l5 = Dict(:color => cp[4], :linestyle => :dashdotdot)
	function set()
		default(size=(600, 400), foreground_color_legend=nothing, margin=3Plots.mm, linewidth=1.5, legendtitlefontsize=10.0, minorgrid = true)
		default(:bglegend,plot_color(default(:bg), 0.2))
		default(:fglegend,plot_color(default(:bg), 0.2))
	end
end
# %%

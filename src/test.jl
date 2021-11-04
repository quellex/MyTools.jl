# %%
include("plotrecipe.jl")
using .MyPlot
# %%
MyPlot.cp
plot(rand(10))
# %%
MyPlot.set()
plot(rand(10))

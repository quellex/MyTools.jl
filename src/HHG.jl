using FFTW
function HHG(f::TVF) where TVF<:AbstractVector{<:AbstractFloat}
	n = length(f)
	spec = fft(f)
	return abs.(spec).^2/n^2
end
function HHGfreq(f::TVF, ncyc) where TVF<:AbstractVector{<:AbstractFloat}
	x = collect(range(1, length(f), length = length(f)))
	return x./ncyc
end
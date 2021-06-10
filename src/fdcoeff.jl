using OffsetArrays
const fdc1_2 = [0, 1/2]
const fdc1_4 = [0, 2/3, -1/12]
const fdc1_6 = [0, 3/4, -3/20, 1/60 ]
const fdc1_8 = [0, 4/5, -1/5 , 4/105, -1/280]
const fdc2_2 = [-2, 1]
const fdc2_4 = [-5/2,    4/3, -1/12]
const fdc2_6 = [-49/18 , 3/2, -3/20, 1/90]
const fdc2_8 = [-205/72, 8/5, -1/5,  8/315, -1/560]
const fdc1 = [fdc1_2, fdc1_4, fdc1_6, fdc1_8]
const fdc2 = [fdc2_2, fdc2_4, fdc2_6, fdc2_8]
fdcoeff1 = Vector{OffsetVector{Float64, Vector{Float64}}}(undef, 4)
fdcoeff2 = Vector{OffsetVector{Float64, Vector{Float64}}}(undef, 4)
function init!(fdcoeff1, fdcoeff2)
	 for i in 1:4
		tmp1 = zeros(2*i + 1)
		tmp1[i + 1] = fdc1[i][1]
		tmp2 = zeros(2*i + 1)
		tmp2[i + 1] = fdc2[i][1]
		for k in 1:i
			tmp1[i + 1 + k] =  fdc1[i][k+1]
			tmp1[i + 1 - k] = -fdc1[i][k+1]
			tmp2[i + 1 + k] =  fdc2[i][k+1]
			tmp2[i + 1 - k] = -fdc2[i][k+1]
		end
		fdcoeff1[i] = OffsetVector(tmp1, -i:i)
		fdcoeff2[i] = OffsetVector(tmp2, -i:i)
	end
end
init!(fdcoeff1, fdcoeff2)
cycindex(i,n) = (i + n - 1)%n + 1
function makefd1mat(n::Integer, dh, order = 2; bc = :Zero)
	@assert order in Set([2,4,6,8])
	@assert bc in Set([:Zero, :Periodic])
	mat = zeros(typeof(dh), (n, n))
	m = div(order, 2)
	if bc == :Zero
		for i in 1:n
			mat[i,i] = fdcoeff1[m][0]
			for k in 1:m
				if i + k ≤ n
					mat[i,i + k] = fdcoeff1[m][ k]
				end
				if 1 ≤ i - k
					mat[i,i - k] = fdcoeff1[m][-k]
				end
			end
		end
	else
		for i in 1:n
			mat[i,i] = fdcoeff1[m][0]
			for k in 1:m
				mat[i,cycindex(i + k, n)] = fdcoeff1[m][ k]
				mat[i,cycindex(i - k, n)] = fdcoeff1[m][-k]
			end
		end
	end
	mat ./= dh
	return mat
end
function makefd2mat(n::Integer, dh, order = 2; bc = :Zero)
	@assert order in Set([2,4,6,8])
	@assert bc in Set([:Zero, :Periodic])
	mat = zeros(typeof(dh), (n, n))
	m = div(order, 2)
	if bc == :Zero
		for i in 1:n
			mat[i,i] = fdcoeff2[m][0]
			for k in 1:m
				if i + k ≤ n
					mat[i,i + k] = fdcoeff2[m][ k]
				end
				if 1 ≤ i - k
					mat[i,i - k] = fdcoeff2[m][-k]
				end
			end
		end
	else
		for i in 1:n
			mat[i,i] = fdcoeff2[m][0]
			for k in 1:m
				mat[i,cycindex(i + k, n)] = fdcoeff2[m][ k]
				mat[i,cycindex(i - k, n)] = fdcoeff2[m][-k]
			end
		end
	end
	mat ./= dh^2
	return mat
end

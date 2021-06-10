function getmembers(s;kwargs...)
	dict = Dict{Symbol, Any}()
	for symb in fieldnames(typeof(s))
		dict[symb] = getfield(s, symb)
	end
	return dict
end
function modify(s;kwargs...)
	dict = getmembers(s)
	for (k, v) in kwargs
		if haskey(dict, k)
			dict[k] = v
		end
	end
	return typeof(s)(;dict...)
end
keytosymbol(x) = Dict(Symbol(k) => v for (k, v) in pairs(x))
function convertdict(S, fname::String)
	dict = JSON.parsefile(fname)
	res = Dict()
	for (k, v) in pairs(dict)
		T = fieldtype(S, Symbol(k))
		if T != String
			res[k] = eltype(T).(v)
		else
			res[k] = (T).(v)
		end
	end
	return S(InputFile=fname;keytosymbol(res)...)
end

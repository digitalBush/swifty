defmodule Swifty.Utils do

	def split_path(path) do
		parts=String.split(path, "/") |> Enum.filter &(&1 != "") 
		Enum.map parts,&generate_part/1
	end

	defp generate_part(<<?:, param :: binary>>) do 
		quote do var!(unquote(binary_to_atom param)) end 
	end
	defp generate_part(part), do: part

end
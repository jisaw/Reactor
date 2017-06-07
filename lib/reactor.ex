defmodule Reactor.CLI do
  def main(args \\ []) do
    args
    |> parse_args
    |> response
    |> output
  end

  defp parse_args(args) do 
    parsed_args = 
      args
      |> OptionParser.parse(switches: [new: :boolean],
                            aliases: [n: :new])
    case parsed_args do
      { [new: true], class_name, _ } ->  {:new, class_name}
    end
  end

  defp response({:new, class_name}) do
    {:ok, template} =  File.read("resources/new_react_class.txt")

    class_body = 
      template
      |> EEx.eval_string([component_name: class_name])

    {:new, class_name, class_body}
  end

  defp output({:new, class_name, class_body}) do
    File.write("#{class_name}.js", class_body)
  end

end

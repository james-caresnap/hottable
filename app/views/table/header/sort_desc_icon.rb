module Views
  class Table
    class Header
      class SortDescIcon < Phlex::SVG
        def view_template
          svg class: "h-3 w-3 text-orange-500 order-last", viewBox: "0 0 425 233.7", fill: "currentColor", focusable: "false", aria_hidden: "true" do
            path d: "M10.6 10.6l201.9 201.9L414.4 10.6"
          end
        end
      end
    end
  end
end

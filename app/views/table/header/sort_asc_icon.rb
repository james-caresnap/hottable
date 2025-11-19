module Views
  class Table
    class Header
      class SortAscIcon < Phlex::SVG
        def view_template
          svg class: "h-3 w-3 text-orange-500 order-first", viewBox: "0 0 425 233.7", fill: "currentColor", focusable: "false", aria_hidden: "true" do
            path d: "M414.4 223.1L212.5 21.2 10.6 223.1"
          end
        end
      end
    end
  end
end

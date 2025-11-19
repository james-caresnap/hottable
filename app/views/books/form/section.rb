module Views
  class Books::Form::Section < ApplicationComponent
    attr_reader :attributes

    def initialize(id:, type: :button, pinned: :right, **attributes)
      @id = normalize_id(id)
      @type = type
      @pinned = pinned
      @attributes = attributes.except(:id, "id")
      @attributes[:id] = @id
    end

    def view_template
      popover_attributes = default_component_attributes
      popover_attributes[:id] = @id

      render PopoverComponent.new(**popover_attributes) do |popover|
        @popover = popover

        yield
      end
    end

    def title(icon:, colored: false, classes: nil, &block)
      @popover.trigger class: tokens("inline-flex items-center justify-center gap-2 w-full rounded-md border-2 border-transparent bg-white px-4 py-2 font-medium text-gray-700 focus:ring-offset-gray-100", -> { colored } => classes, -> { !colored } => "group-open:border-gray-200 hover:border-gray-300") do
        render Bootstrap::IconComponent.new(icon, class: "text-xl")

        span class: "whitespace-nowrap", &block
      end
    end

    def body(&block)
      @popover.portal class: tokens("mt-1 divide-y divide-gray-100 rounded-md bg-white border-2 shadow-lg overflow-auto max-h-[calc(100vh-250px)] focus:outline-none", -> { @type == :button } => "min-w-72"), &block
    end

    private

    def normalize_id(value)
      return value if value.is_a?(Symbol)

      value.to_s.downcase.to_sym
    end

    def default_component_attributes
      { align: :end, class: "inline-block text-left z-30" }.merge(@attributes)
    end
  end
end

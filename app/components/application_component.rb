require "phlex/rails"
require "phlex/svg"

class ApplicationComponent < Phlex::HTML
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::RecordIdentifier
  include Rails.application.routes.url_helpers

  delegate :request, to: :view_context
  delegate :params, to: :view_context

  def tokens(*tokens, **conditional_tokens)
    conditional_tokens.each do |condition, token|
      case condition
      when Symbol then next unless send(condition)
      when Proc then next unless condition.call
      else raise ArgumentError,
                  "The class condition must be a Symbol or a Proc."
      end

      case token
      when Symbol then tokens << token.name
      when String then tokens << token
      when Array then tokens.concat(token)
      else raise ArgumentError,
                  "Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings."
      end
    end

    tokens.compact.join(" ")
  end

  class Struct
    private

    def tokens(*tokens, **conditional_tokens)
      conditional_tokens.each do |condition, token|
        case condition
        when Symbol then next unless send(condition)
        when Proc then next unless condition.call
        else raise ArgumentError,
                    "The class condition must be a Symbol or a Proc."
        end

        case token
        when Symbol then tokens << token.name
        when String then tokens << token
        when Array then tokens.concat(token)
        else raise ArgumentError,
                    "Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings."
        end
      end

      tokens.compact.join(" ")
    end
  end

  # Attributes that Phlex 2 requires as symbols
  SYMBOL_ATTRIBUTES = %w[id class].freeze

  def attributify(*attribute_hashes)
    flat_attribute_hashes = attribute_hashes.map { flatten_attributes_hash(_1) }

    flat_attribute_hashes.reduce({}) do |memo, attribute_hash|
      memo.deep_merge(attribute_hash) do |attribute, oldval, newval|
        attr_name = attribute.is_a?(Symbol) ? attribute.name : attribute
        next newval unless ["class", "data-controller", "data-action"].include?(attr_name)
        next newval if attr_name.end_with?("!")

        [oldval, newval].uniq.join(' ')
      end
    end
  end

  def flatten_attributes_hash(input, keys = [], output = {})
    unless input.is_a?(Hash)
      key_str = keys.join('-')
      # Keep certain attributes as symbols for Phlex 2 compatibility
      final_key = SYMBOL_ATTRIBUTES.include?(key_str) ? key_str.to_sym : key_str
      return output.merge!(final_key => input)
    end

    input.each do |key, value|
      name = case key
        when String
          key
        when Symbol
          key.name.tr("_", "-")
        else
          key.to_s
        end

      flatten_attributes_hash(
        value,
        keys + Array[name],
        output
      )
    end

    output
  end
end

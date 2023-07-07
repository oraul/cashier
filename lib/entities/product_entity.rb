# frozen_string_literal: true

ProductEntity = Struct.new(:code, :name, :price_in_cents, :rule, keyword_init: true) do
  attr_reader :errors

  def calculate_in_cents(total)
    rule.call(total, price_in_cents)
  end

  def valid?
    @errors = Hash.new { |hash, key| hash[key] = [] }

    @errors[:code] << 'is empty' if empty?(:code)
    @errors[:name] << 'is empty' if empty?(:name)
    @errors[:price_in_cents] << 'is not integer' unless integer?(:price_in_cents)

    @errors.empty?
  end

  private

  def empty?(attribute_name)
    public_send(attribute_name).nil? || public_send(attribute_name).empty?
  end

  def integer?(attribute_name)
    public_send(attribute_name).instance_of?(Integer)
  end
end

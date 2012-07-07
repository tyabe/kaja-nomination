class Setting < ActiveRecord::Base

  @@available_settings = {
    "site_title"       => "Vote for RubyKaja",
    "site_description" => "Description of This Site.",
    "site_keywords"    => "RubyKaja, Ruby, Vote",
    "community"        => "",
    "message"          => "Message to the voters"
  }

  # Fields
  field :name, index: {unique: true}
  field :value, as: :text

  timestamps

  # Validations
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_length_of     :name, maximum: 255
  validates_inclusion_of  :name, in: @@available_settings.keys

  @@available_settings.each do |name, params|
    src = <<-END_SRC
    def self.#{name}
      self[:#{name}]
    end

    def self.#{name}=(value)
      self[:#{name}] = value
    end

    def self.#{name}?
      self[:#{name}].present?
    end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end

  def value
    read_attribute(:value)
  end

  def value=(v)
    write_attribute(:value, v.to_s)
  end

  @cached_settings = {}

  class << self

    def [](name)
      @cached_settings[name] || (@cached_settings[name] = find_or_default(name).value)
    end

    def []=(name, v)
      setting = find_or_default(name)
      setting.value = (v ? v : "")
      @cached_settings[name] = nil
      setting.save
      setting.value
    end

    def clear_cache
      @cached_settings.clear
      @cached_cleared_on = Time.now
      logger.info "Settings cache cleared." if logger
    end

    def has_key?(name)
      @@available_settings.has_key?(name)
    end

  end


  def self.find_or_default(name)
    name = name.to_s
    raise ArgumentError, "named '#{name}' is not registered" unless @@available_settings.has_key?(name)
    find_by_name(name) || new(name: name, value: @@available_settings[name])
  end

end

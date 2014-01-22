require 'optparse'

class ParseArguments
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: beertracks [command][option]"

      opts.on("--style [STYLE]", "The style") do |style|
        options[:style] = style
      end

      opts.on("--cost [COST]", "The cost") do |cost|
        options[:cost] = cost
      end

      opts.on("--oz [OUNCES]", "The ounces") do |ounces|
        options[:ounces] = ounces
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
       options[:environment] = env
      end
    end.parse!
    options
  end

  def self.validate options
    errors = []
    if options[:name].nil? or options[:name].empty?
      errors << "You must provide the name of the beer you drank.\n"
    end

    missing_things = []
    missing_things << "style" unless options[:style]
    missing_things << "cost" unless options[:cost]
    missing_things << "total ounces" unless options[:ounces]
    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} of the beer you drank.\n"
    end
    errors
  end
end
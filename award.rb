Award = Struct.new(:name, :expires_in, :quality) do

  # Constructs an instance of Award using the appropriate subclass
  def self.new(*args)
    # TODO case-insensitive name comparison
    subclass = case args.first
               when 'Blue Compare'
                 BlueCompareAward
               when 'Blue Distinction Plus'
                 BlueDistinctionPlusAward
               when 'Blue First'
                 BlueFirstAward
               when 'Blue Star'
                 BlueStarAward
               else # everything else is a plain old Award
                 NormalAward
               end
    subclass.new(*args)
  end
end

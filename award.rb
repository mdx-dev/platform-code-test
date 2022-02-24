Award = Struct.new(:name, :expires_in, :quality) #this will be called in the spec rb file where they will need to give the three methods

#For Reference to help setting this up
# Award.new('NORMAL ITEM', 5, 10),
# Award.new('Blue First', 3, 10),

class Award #we need to first setup the class for the awards

    attr_accessor :name, :expires_in, :quality #in order to save time let Ruby create the methods for us by using the accessor

    #Why? Attr_accessor allows access to the returned instance variable 
    #and also change the value of the returned instance variable
    #Best of both worlds in attr_writer and attr_reader

    def initialize(name, expires_in, quality) #initialize the methods so we can do some magic with them
        @name = name
        @expires_in = expires_in
        @quality = quality
    end

    #Basic Max and Min Methods to determine (for use later in code)

    def maximum_value (a,b)
        if a > b
            a
        else
            b
        end
    end

    def minimum_value (a,b)
        if a > b
            b
        else
            a
        end
    end

    def update_award_quality

        if @name != 'Blue Distinction Plus' #based on business rule we should not let this award expire (check spec file for confirmation)
            expiration_update #decrease expiration method
        end
        
        #Starting with Normal Item and Blue First based on Spec file investigation
        if @name == 'NORMAL ITEM' #Not entirely sure if case sensitivity matters but keeping it caps lock on after looking at spec file
            normal_quality_update #calls on normal_quality_update below where we to implement the business rules
            
            elsif @name == 'Blue First' #Increasing as expiration increases
                blue_first_quality_update
            
            elsif @name == 'Blue Compare'
                blue_comp_quality_update
            
            elsif @name == 'Blue Star' #New Award!
                blue_star_quality_update
        
            end

    end

    def expiration_update #this method updates the expiration each time update_award_quality is invoked
        @expires_in -= 1
    end

    def normal_quality_update
        @quality = maximum_value(@quality - 1, 0)
        if @expires_in < 0
            @quality = maximum_value(@quality - 1, 0) #The quality of an award is never negative.
        end
    end

    #Lets add the new award
    def blue_star_quality_update
        @quality = maximum_value(@quality - 2, 0) #"Blue Star" awards should lose quality value twice as fast as normal awards.

        if @expires_in < 0
            @quality = maximum_value(@quality - 2, 0)
        end

    end

    def blue_first_quality_update
      if @quality < 50 #quality may start at 10 based on spec file
            @quality += 1 #"Blue First" awards increase in quality the older they get
        
        if @expires_in < 0
            @quality = minimum_value(quality + 1, 50) #The quality of an award is never more than 50 and The quality of an award is never negative.
                                                      #hence why we go the minimum route. 
        end
      end
    end

    def blue_comp_quality_update
      if @quality < 50
            @quality += 1 #"Blue Compare", similar to "Blue First", increases in quality as the expiration date approaches; 

            if @expires_in <= 10 && @expires_in > 5
                @quality += 1 #Quality increases by 2 when there are 10 days or less left 
 
            elsif @expires_in <= 5 && expires_in >= 0
                @quality += 2 #By 3 where there are 5 days or less left
            
            elsif @expires_in < 0
                @quality = 0 #Quality value drops to 0 after the expiration date but cannot be < 0
            end
        
        end
    end

end
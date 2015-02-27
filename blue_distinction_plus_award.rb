class BlueDistinctionPlusAward < NormalAward

    def update_quality_and_decrement_expires_in!
      # "Blue Distinction Plus", being a highly sought distinction, never decreases in quality
      # and apparently never has its expires_in reduced
    end

end

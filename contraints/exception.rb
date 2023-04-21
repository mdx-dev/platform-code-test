class Exception
    def update_quality(award)
        ##if name is blue distinciton plus, quality should be 80 and should not expire
        award.quality = 80 if award.name == 'Blue Distinction Plus'
        award.expires_in -= 1 if award.name != 'Blue Distinction Plus'
    end
end
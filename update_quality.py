MIN      = 0
MAX      = 50
INCREASE = True
DECREASE = False 

def update_quality(awards):

    for award in awards:
        quality_business_logic(award)
        expiration_business_logic(award)


def quality_business_logic(award):

    if award.name == 'Blue First':
        process_blue_first(award)

    elif award.name == 'Blue Distinction Plus':
        process_blue_distinction_plus(award)

    elif award.name == 'Blue Compare':
        process_blue_compare(award)

    elif award.name == 'Blue Star':
        process_blue_star(award)

    else:
        process_normal(award)
 

def process_blue_first(award):

    if award.expires_in <= 0:
        adjust_quality(award, INCREASE, 2);
    else:
        adjust_quality(award, INCREASE, 1);


def process_blue_distinction_plus(award):

    ## no need to do anything. quality is always 80
    award.quality = 80


def process_blue_compare(award):

    if award.expires_in <= 0:
        award.quality = 0
    elif award.expires_in <= 5:
        adjust_quality(award, INCREASE, 3);
    elif award.expires_in <= 10:
        adjust_quality(award, INCREASE, 2);
    else:
        adjust_quality(award, INCREASE, 1);


def process_normal(award):

    if award.expires_in <= 0:
        adjust_quality(award, DECREASE, 2);
    else:
        adjust_quality(award, DECREASE, 1);


def process_blue_star(award):

    if award.expires_in <= 0:
        adjust_quality(award, DECREASE, 4);
    else:
        adjust_quality(award, DECREASE, 2);


def adjust_quality(award, increase, amount):

    if  increase:
        award.quality += amount;
    else:
        award.quality -= amount;

    if  award.quality < MIN:
        award.quality = MIN

    if  award.quality > MAX:
        award.quality = MAX


def expiration_business_logic(award):

        ## decrease expires_in for all.  for some reason, the test 
        ## case do expect it to be decremented for Plus.  I guess it 
        ## does not matter, but there is no requirement.
        if award.name != 'Blue Distinction Plus':
            award.expires_in -= 1

# Vitals Code Test

# Description
Hi, and welcome to the team! As you know, we provide tools for searching for doctors and hospitals (i.e. "providers") based on various criteria. One type of search that we provide is to find providers that are highly rated by quality.

To calculate quality, one measure we use is a score based on professional award recognitions. Each award is factored in slightly differently.

- All awards have an expires_in value which denotes the number of days until the award expires.

- All awards have a quality value which denotes how valuable the award is in our overall calculation.

- At the end of each day our system recalculates both values for every award based on business rules.

Pretty basic. But here is where it gets interesting...

  - Once the expiration date has passed, quality score degrades twice as fast

  - The quality of an award is never negative.
  
  - "Blue First" awards actually increase in quality the older they get

  - The quality of an award is never more than 50

  - "Blue Distinction Plus", being a highly sought distinction, never decreases in quality

  - "Blue Compare", similar to "Blue First", increases in quality as the expiration date approaches; Quality increases by 2 when there are 10 days or less left, and by 3 where there are 5 days or less left, but quality value drops to 0 after the expiration date.

  - Just for clarification, an award can never have its quality increase above 50, however "Blue Distinction Plus", being highly sought, its quality is 80 and it never alters.

We have recently gotten a request from our clients to include an additional award in our quality calculations. This requires an update to our system.

# Your Assignment

Here is the business story:

- In order to distinguish between providers of high quality, as a consumer, I want to see "Blue Star" awarded providers near the top of the results when the award is initially granted, but it's impact should be smaller the longer it has been from the grant date.

- Acceptance Criteria
  - "Blue Star" awards should lose quality value twice as fast as normal awards.

During Sprint Planning, you estimated the story to be between 1 and 3 story points (in general, this corresponds to a few hours to a couple of days). We have committed to complete this by the end of our Sprint which ends soon. Please fork the code and submit a link to your fork with your changes when you have completed the assignment.

The existing code is "legacy", and, ugh, it's ugly. Feel free to make any changes to the code as long as everything still works correctly and all specs pass. (Although, note that Awards are used elsewhere in the system, so their public interface must remain backward compatible).

## Installation Hints

The easiest way is to use bundler to install the dependencies. To do so, you need to install the bundler gem if you havent already done so

    gem install bundler

run bundler

    bundle

and should be ready to go. Alternatively, you can install the dependencies one by one using gem install, e.g.

    gem install rspec

Have a look at the Gemfile for all dependencies.

## Testing

To test your work, run the default rake task:

    rake



from award_quality_daily_decay_job import AwardQualityDailyDecayJob


def update_quality(awards):
    for award in awards:
        AwardQualityDailyDecayJob.run_job(award)

from award import Award


class AwardQualityDailyDecayJob:
    @classmethod
    def run_job(cls, award: Award) -> None:
        if award is None:
            return

        award.decrement_expires_in()

        award.decay_quality()

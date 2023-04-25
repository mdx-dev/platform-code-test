from mock import patch

from award import Award
from award_quality_daily_decay_job import AwardQualityDailyDecayJob


def test_award_expires_in_is_decremented():
    award = Award("some name", 10, 100)

    with patch.object(award, "decay_quality"):
        AwardQualityDailyDecayJob.run_job(award)

        assert award.expires_in == 9

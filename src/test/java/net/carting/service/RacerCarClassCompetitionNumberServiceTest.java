package net.carting.service;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.HashSet;
import java.util.Set;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class RacerCarClassCompetitionNumberServiceTest {

    @InjectMocks
    private RacerCarClassCompetitionNumberServiceImpl racerCarClassCompetitionNumberService;

    @Mock
    private RacerService racerService;

    @Mock
    private CarClassCompetitionService carClassCompetitionService;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetRacerCarClassesCompetitionNumbersFromString() {
        String racerCarClassesCompetitionNumbersStr = "1,1,1#2,2,2";

        Set<RacerCarClassCompetitionNumber> racerCarClassesCompetitionNumbers = new HashSet<RacerCarClassCompetitionNumber>();

        Racer racer1 = new Racer();
        when(racerService.getRacerById(1)).thenReturn(racer1);
        CarClassCompetition ccc1 = new CarClassCompetition();
        when(carClassCompetitionService.getCarClassCompetitionById(1))
                .thenReturn(ccc1);
        racerCarClassesCompetitionNumbers
                .add(new RacerCarClassCompetitionNumber(racer1, ccc1, 1));

        Racer racer2 = new Racer();
        when(racerService.getRacerById(2)).thenReturn(racer2);
        CarClassCompetition ccc2 = new CarClassCompetition();
        when(carClassCompetitionService.getCarClassCompetitionById(2))
                .thenReturn(ccc2);
        racerCarClassesCompetitionNumbers
                .add(new RacerCarClassCompetitionNumber(racer2, ccc2, 2));

        assertEquals(
                "Expected Set<RacerCarClassCompetitionNumber>",
                racerCarClassesCompetitionNumbers,
                racerCarClassCompetitionNumberService
                        .getRacerCarClassesCompetitionNumbersFromString(racerCarClassesCompetitionNumbersStr));

    }

}

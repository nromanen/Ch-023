package net.carting.service;

import junitparams.JUnitParamsRunner;
import junitparams.Parameters;
import net.carting.dao.RaceDAO;
import net.carting.dao.RaceResultDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.*;

import static junit.framework.Assert.assertEquals;
import static junitparams.JUnitParamsRunner.$;
import static org.mockito.Mockito.*;

@RunWith(JUnitParamsRunner.class)
public class RaceServiceTest {

    @InjectMocks
    RaceServiceImpl raceServiceImpl;

    @Mock
    private RaceDAO raceDAO;

    @Mock
    private RaceResultDAO raceResultDAO;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllRaces() {
        List<Race> raceList = new ArrayList<Race>();
        raceList.add(new Race());
        raceList.add(new Race());
        when(raceDAO.getAllRaces()).thenReturn(raceList);
        assertEquals("Expected 2 races", 2, raceServiceImpl.getAllRaces().size());
    }

    @Test
    public void testAddRace() throws Exception {
        Race race = new Race();
        race.setRaceNumber(1);

        raceServiceImpl.addRace(race);
        verify(raceDAO, times(1)).addRace(race);
    }

    @Test
    public void testUpdateRace() throws Exception {
        Race race = new Race();
        race.setRaceNumber(1);
    }

    @Test
    public void testDeleteRace() throws Exception {
        Race race = new Race();
        race.setRaceNumber(1);
        raceServiceImpl.deleteRace(race);
        verify(raceDAO, times(1)).deleteRace(race);
    }

    @Test
    public void testGetRacesByCarClassCompetition() throws Exception {
        List<Race> raceList = new ArrayList<Race>();
        Race race1 = new Race();
        Race race2 = new Race();
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setCircleCount(5);
        race1.setNumberOfLaps(5);
        race1.setNumberOfLaps(10);
        raceList.add(race1);
        raceList.add(race2);
        when(raceDAO.getRacesByCarClassCompetition(carClassCompetition)).thenReturn(raceList);
        assertEquals("Expected 2 races", 2, raceServiceImpl.getRacesByCarClassCompetition(carClassCompetition).size());
    }

    @Test
    public void testSetRaceNumber() {
        Race race = new Race();
        race.setRaceNumber(1);
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setCircleCount(5);
        List<Race> raceList = new ArrayList<Race>();
        raceList.add(race);
        when(raceDAO.getRacesByCarClassCompetition(carClassCompetition)).thenReturn(raceList);
        assertEquals("Expected number 2", 1, raceList.size());
    }

    @Test
    public void testGetChessRoll() {

        Race race = new Race();
        race.setResultSequance("1 2 3 5 2 5 1 1 2 3 5");
        race.setNumberOfLaps(3);
        race.setNumberOfMembers(4);

        List<Set<Integer>> chessRoll = new ArrayList<Set<Integer>>() {
            {
                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{1, 2, 3, 5})));
                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 5, 1, 3})));
                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{1, 2, 5})));
            }
        };

        assertEquals(chessRoll, raceServiceImpl.getChessRoll(race));
    }

    @Test
    @Parameters(method = "chessParameters")
    public void testGetChessRoll(Race race, ArrayList<LinkedHashSet<Integer>> expected) {
        assertEquals(expected, raceServiceImpl.getChessRoll(race));

    }


    private Object[] chessParameters() {
        return $(

                $(new Race("15 61 3 4 7 21 9 8 24 33 15 61 4 7 3 21 9 8 33 15 24 61 4 7 3 21 9 33 8 15 4 " +
                                "61 7 24 3 21 9 33 15 4 8 61 7 24 9 21 3 15 33 4 61 7 8 9 21 24 3", 6, 10),
                        new ArrayList<Set<Integer>>() {
                            {
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{15, 61, 3, 4, 7, 21, 9, 8, 24, 33})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{15, 61, 4, 7, 3, 21, 9, 8, 33, 24})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{15, 61, 4, 7, 3, 21, 9, 33, 8, 24})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{15, 4, 61, 7, 3, 21, 9, 33, 8, 24})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{15, 4, 61, 7, 9, 21, 3, 33, 8, 24})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{15, 4, 61, 7, 9, 21, 3})));
                            }
                        }),
                $(new Race("12 4 8 9 12 4 8 9 12 4 8 9 12 4", 4, 4),
                        new ArrayList<Set<Integer>>() {
                            {
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{12, 4, 8, 9})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{12, 4, 8, 9})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{12, 4, 8, 9})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{12, 4,})));
                            }
                        }),
                $(new Race("1 2 3 9 2 9 1 1 2 3 9 ", 3, 4),
                        new ArrayList<Set<Integer>>() {
                            {
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{1, 2, 3, 9})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{1, 2, 9})));
                            }
                        }),
                $(new Race("1 2 3 5 2 5 1 1 2 3 5", 3, 4),
                        new ArrayList<Set<Integer>>() {
                            {
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{1, 2, 3, 5})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 5, 1, 3})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{1, 2, 5})));
                            }
                        }),
                $(new Race("2 9 1 2 9 2 1 3 7 3 7 2 9 1 3 7 2 9 1 3 7 9 1 2 9 2 9 1 3 7 2 9 1 3 7 2 3 7 1 9 2 ", 10, 5),
                        new ArrayList<Set<Integer>>() {
                            {
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1, 3, 7})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9, 1})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2, 9})));
                                add(new LinkedHashSet<Integer>(Arrays.asList(new Integer[]{2})));
                            }
                        })
        );
    }

}
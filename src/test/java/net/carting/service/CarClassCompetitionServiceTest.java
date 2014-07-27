package net.carting.service;

import net.carting.dao.CarClassCompetitionDAO;
import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.domain.*;
import net.carting.util.DateUtil;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class CarClassCompetitionServiceTest {

    @InjectMocks
    CarClassCompetitionServiceImpl carClassCompetitionServiceImpl;

    @Mock
    RacerCarClassCompetitionNumberDAO racerCarClassCompetitionNumberDAO;

    @Mock
    CarClassCompetitionDAO carClassCompetitionDAO;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetNotValidRacersToRegistration() {

        //----car classes------------------
        CarClass carClass1 = new CarClass();
        carClass1.setName("����������");
        carClass1.setLowerYearsLimit(16);
        carClass1.setUpperYearsLimit(99);

        CarClass carClass2 = new CarClass();
        carClass2.setName("ϲ����-�");
        carClass2.setLowerYearsLimit(15);
        carClass2.setUpperYearsLimit(19);
        //------------------------

        //-----team and racers-----------
        Team team = new Team();
        team.setName("team1");

        Racer racer1 = new Racer();
        racer1.setBirthday(DateUtil.getDateFromString("1990-05-05"));//valid date for ����������
        Racer racer2 = new Racer();
        racer2.setBirthday(DateUtil.getDateFromString("2005-05-05"));//not valid date for ����������
        Racer racer3 = new Racer();
        racer3.setBirthday(DateUtil.getDateFromString("1998-05-05"));//valid date for ϲ����-�
        Racer racer4 = new Racer();
        racer4.setBirthday(DateUtil.getDateFromString("1990-05-05"));//valid date for ����������

        Set<Racer> racers = new HashSet<Racer>();
        racers.add(racer1);
        racers.add(racer2);
        racers.add(racer3);
        racers.add(racer4);

        team.setRacers(racers);
        //---------------------------------------

        //-------racers car classes and default numbers----------------
        RacerCarClassNumber racerCarClassNumber1 = new RacerCarClassNumber();
        racerCarClassNumber1.setCarClass(carClass1);
        racerCarClassNumber1.setRacer(racer1);

        RacerCarClassNumber racerCarClassNumber2 = new RacerCarClassNumber();
        racerCarClassNumber2.setCarClass(carClass1);
        racerCarClassNumber2.setRacer(racer2);

        RacerCarClassNumber racerCarClassNumber3 = new RacerCarClassNumber();
        racerCarClassNumber3.setCarClass(carClass2);
        racerCarClassNumber3.setRacer(racer3);

        RacerCarClassNumber racerCarClassNumber4 = new RacerCarClassNumber();
        racerCarClassNumber4.setCarClass(carClass1);
        racerCarClassNumber4.setRacer(racer4);

        Set<RacerCarClassNumber> racerCarClassNumbers1 = new HashSet<RacerCarClassNumber>();
        racerCarClassNumbers1.add(racerCarClassNumber1);
        Set<RacerCarClassNumber> racerCarClassNumbers2 = new HashSet<RacerCarClassNumber>();
        racerCarClassNumbers2.add(racerCarClassNumber2);
        Set<RacerCarClassNumber> racerCarClassNumbers3 = new HashSet<RacerCarClassNumber>();
        racerCarClassNumbers3.add(racerCarClassNumber3);
        Set<RacerCarClassNumber> racerCarClassNumbers4 = new HashSet<RacerCarClassNumber>();
        racerCarClassNumbers4.add(racerCarClassNumber4);

        racer1.setCarClassNumbers(racerCarClassNumbers1);//����������
        racer2.setCarClassNumbers(racerCarClassNumbers2);//����������
        racer3.setCarClassNumbers(racerCarClassNumbers3);//ϳ����-�
        racer4.setCarClassNumbers(racerCarClassNumbers4);//����������
        //-------------------------------------------

        //----car class competition----------
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setId(1);
        carClassCompetition.setCarClass(carClass1);//����������, racer with class ϲ����-� is not valid!
        //-----------------------------

        //------------registred racers--------------------
        RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = new RacerCarClassCompetitionNumber();
        racerCarClassCompetitionNumber.setCarClassCompetition(carClassCompetition);
        racerCarClassCompetitionNumber.setRacer(racer4);

        List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers = new ArrayList<RacerCarClassCompetitionNumber>();
        racerCarClassCompetitionNumbers.add(racerCarClassCompetitionNumber);
        //-----------------------------------------------

        when(racerCarClassCompetitionNumberDAO.
                getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(
                        carClassCompetition.getId(), team.getId()))
                .thenReturn(racerCarClassCompetitionNumbers);

        when(carClassCompetitionDAO.getCarClassCompetitionById(carClassCompetition.getId())).thenReturn(carClassCompetition);

        assertEquals("Expected 3 results", 3, (carClassCompetitionServiceImpl
                .getNotValidRacersToRegistration(carClassCompetition.getId(), team).size()));

    }

}

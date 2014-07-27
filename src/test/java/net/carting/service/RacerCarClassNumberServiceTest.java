package net.carting.service;

import net.carting.dao.RacerCarClassNumberDAO;
import net.carting.domain.CarClass;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class RacerCarClassNumberServiceTest {

    @InjectMocks
    private RacerCarClassNumberServiceImpl racerCarClassNumberService;

    @Mock
    RacerCarClassNumberDAO racerCarClassNumberDAO;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void getNumbersByCarClassIdTest() {

        String separator = ",";

        CarClass carClass = new CarClass();
        carClass.setId(1);
        carClass.setName("����������");

        Racer racer1 = new Racer();
        Racer racer2 = new Racer();
        Racer racer3 = new Racer();
        Racer racer4 = new Racer();

        RacerCarClassNumber racerCarClassNumber1 = new RacerCarClassNumber();
        racerCarClassNumber1.setCarClass(carClass);
        racerCarClassNumber1.setRacer(racer1);
        racerCarClassNumber1.setNumber(1);

        RacerCarClassNumber racerCarClassNumber2 = new RacerCarClassNumber();
        racerCarClassNumber2.setCarClass(carClass);
        racerCarClassNumber2.setRacer(racer2);
        racerCarClassNumber2.setNumber(2);

        RacerCarClassNumber racerCarClassNumber3 = new RacerCarClassNumber();
        racerCarClassNumber3.setCarClass(carClass);
        racerCarClassNumber3.setRacer(racer3);
        racerCarClassNumber3.setNumber(3);

        RacerCarClassNumber racerCarClassNumber4 = new RacerCarClassNumber();
        racerCarClassNumber4.setCarClass(carClass);
        racerCarClassNumber4.setRacer(racer4);
        racerCarClassNumber4.setNumber(4);

        List<RacerCarClassNumber> racerCarClassNumbers = new ArrayList<RacerCarClassNumber>();
        racerCarClassNumbers.add(racerCarClassNumber1);
        racerCarClassNumbers.add(racerCarClassNumber2);
        racerCarClassNumbers.add(racerCarClassNumber3);
        racerCarClassNumbers.add(racerCarClassNumber4);

        when(racerCarClassNumberDAO.getNumbersByCarClassId(carClass.getId()))
                .thenReturn(racerCarClassNumbers);

        String expectedResult = "1,2,3,4,";
        String result = racerCarClassNumberService.getNumbersByCarClassId(carClass.getId(), separator);

        assertEquals("Expected true", expectedResult, result);
    }

}

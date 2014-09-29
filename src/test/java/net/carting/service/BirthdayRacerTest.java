package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import junit.framework.Assert;
import net.carting.dao.RacerDAO;
import net.carting.dao.UserDAO;
import net.carting.domain.AdminSettings;
import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.domain.Team;
import net.carting.domain.User;
import net.carting.util.DateUtil;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

public class BirthdayRacerTest {
	 @InjectMocks
	    RacerServiceImpl racerService;

	    @Mock
	    private RacerDAO racerDAO;
    
	@Test
    public void testGetDaysCount() {
		DateUtil dateUtil = new DateUtil();
    	int actual = dateUtil.getDaysCount(Calendar.getInstance().YEAR);
    	int expected = 365;
    	Assert.assertEquals(expected, actual);
    }
	
	@Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }
	@Test
	public void testGetBirthdayRacers() throws ParseException {
		String BDforRacerA = "25.09.1988";
		String BDforRacerB = "27.09.1988";
		String BDforRacerC = "24.09.1988";
		String BDforRacerD = "28.09.1988";
		String BDforRacerE = "26.09.1988";
		Date dateForA = new SimpleDateFormat("dd.MM.yyyy").parse(BDforRacerA);
		Date dateForB = new SimpleDateFormat("dd.MM.yyyy").parse(BDforRacerB);
		Date dateForC = new SimpleDateFormat("dd.MM.yyyy").parse(BDforRacerC);
		Date dateForD = new SimpleDateFormat("dd.MM.yyyy").parse(BDforRacerD);
		Date dateForE = new SimpleDateFormat("dd.MM.yyyy").parse(BDforRacerE);
		List<Racer> racerList = new ArrayList<Racer>();
		Racer racerA = new Racer();
		racerA.setBirthday(dateForA);
		Racer racerB = new Racer();
		racerB.setBirthday(dateForB);
		Racer racerC = new Racer();
		racerC.setBirthday(dateForC);
		Racer racerD = new Racer();
		racerD.setBirthday(dateForD);
		Racer racerE = new Racer();
		racerE.setBirthday(dateForE);
		racerList.add(racerA);
		racerList.add(racerB);
		racerList.add(racerC);
		racerList.add(racerD);
		racerList.add(racerE);
        when(racerService.getBirthdayRacers(dateForE)).thenReturn(racerList);
		assertEquals("Expected 3 racers", 3, racerService.getBirthdayRacers(dateForE).size());
    }

}

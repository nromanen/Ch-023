package net.carting.service;

import net.carting.dao.ManeuverDAO;
import net.carting.domain.Maneuver;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.*;
import static org.mockito.Mockito.*;

/**
 * Created by manson on 15.09.14.
 */
@RunWith(MockitoJUnitRunner.class)
public class ManeuverServiceTest {

    @InjectMocks
    ManeuverServiceImpl maneuverService;

    @Mock
    ManeuverDAO maneuverDAO;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllManeuvers() {
        List<Maneuver> maneuverList = new ArrayList<>();
        maneuverList.add(new Maneuver());
        maneuverList.add(new Maneuver());
        when(maneuverService.getAllManeuvers()).thenReturn(maneuverList);
        assertEquals("Expected 2 maneuvers", 2, maneuverService.getAllManeuvers().size());
        verify(maneuverDAO, times(1)).getAllManeuvers();
        verifyNoMoreInteractions(maneuverDAO);
    }

    @Test
    public void testGetManeuverById() {
        Maneuver m1 = new Maneuver();
        Maneuver m2 = new Maneuver();
        m2.setId(4);
        m2.setName("Test");
        when(maneuverDAO.getManeuverById(0)).thenReturn(m1);
        when(maneuverDAO.getManeuverById(4)).thenReturn(m2);
        assertFalse(maneuverService.getManeuverById(0).equals(new Maneuver()));
        assertTrue(maneuverService.getManeuverById(4).equals(m2));
        verify(maneuverDAO, times(1)).getManeuverById(4);
    }

    @Test
    public void testDeleteManeuverById() {
        Maneuver m2 = new Maneuver();
        m2.setId(4);
        m2.setName("Test");
        maneuverService.deleteManeuver(4);
        verify(maneuverDAO, times(1)).deleteManeuver(4);
        verifyNoMoreInteractions(maneuverDAO);
    }

    @Test
    public void testDeleteManeuverByManeuver() {
        Maneuver maneuver = new Maneuver();
        maneuver.setId(4);
        maneuver.setName("Test");
        maneuverService.deleteManeuver(maneuver);
        verify(maneuverDAO, times(1)).deleteManeuver(maneuver);
        verifyNoMoreInteractions(maneuverDAO);
    }

    @Test
    public void testAddManeuver() {
        Maneuver maneuver = new Maneuver();
        maneuver.setId(4);
        maneuver.setName("Test");
        maneuverService.addManeuver(maneuver);
        when(maneuverDAO.getManeuverById(4)).thenReturn(maneuver);
        assertEquals(maneuverService.getManeuverById(4), maneuver);
    }

    @Test
    public void testUpdateManeuver() {
        String oldName = "old name";
        String newName = "new name";
        Maneuver maneuver = new Maneuver();
        maneuver.setId(4);
        maneuver.setName(oldName);
        when(maneuverDAO.getManeuverById(4)).thenReturn(maneuver);
        assertEquals(maneuverService.getManeuverById(4).getName(), oldName);
        maneuver.setName(newName);
        assertEquals(maneuverService.getManeuverById(4).getName(), newName);
    }
}

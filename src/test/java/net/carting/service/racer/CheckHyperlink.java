package net.carting.service.racer;

import net.carting.service.Util.Locale;
import net.carting.service.Util.SeleniumUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import static org.junit.Assert.assertTrue;

/**
 * Carting
 * Created by manson on 8/11/14.
 */
public class CheckHyperlink {
    private SeleniumUtil seleniumUtil;

    @Before
    public void setUp() throws Exception {
        seleniumUtil = new SeleniumUtil("team1", "1234", Locale.Eng);
    }

    @Test
    public void testCheckHyperlink() throws Exception {
        seleniumUtil.login();
        seleniumUtil.getDriver().findElement(By.xpath("//div[2]/div/div/a[2]")).click();
        assertTrue(seleniumUtil.isElementPresent(By.linkText("Популярний-Юнаки")));
    }

    @After
    public void tearDown() throws Exception {
        seleniumUtil.quit();
    }

}

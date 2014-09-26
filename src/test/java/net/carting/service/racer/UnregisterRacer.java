package net.carting.service.racer;

import net.carting.service.Util.Locale;
import net.carting.service.Util.SeleniumUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

public class UnregisterRacer {
    private SeleniumUtil seleniumUtil;

    @Before
    public void setUp() throws Exception {
        seleniumUtil = new SeleniumUtil("team1", "1234", Locale.Ua);
    }

    @Test
    public void testUnregisterRacer() throws Exception {
        seleniumUtil.login();
        seleniumUtil.getDriver().findElement(By.xpath("//div[2]/div/div/a[2]")).click();
        seleniumUtil.getDriver().findElement(By.cssSelector("b.caret")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Моя команда")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Чемпіонат Чернівецької області (весна 2014 року)")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Популярний")).click();
        seleniumUtil.getDriver().findElement(By.id("unreg21")).click();
        seleniumUtil.getDriver().findElement(By.id("unreg_racer")).click();
    }

    @After
    public void tearDown() throws Exception {
        seleniumUtil.quit();
    }
}

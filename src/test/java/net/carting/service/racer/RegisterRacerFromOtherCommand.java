package net.carting.service.racer;

import net.carting.service.Util.Locale;
import net.carting.service.Util.SeleniumUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.support.ui.Select;

public class RegisterRacerFromOtherCommand {
    private SeleniumUtil seleniumUtil;

    @Before
    public void setUp() throws Exception {
        seleniumUtil = new SeleniumUtil("team1", "1234", Locale.Eng);
    }

    @Test
    public void testRegisterRacerFromOtherCommand() throws Exception {
        seleniumUtil.login();
        seleniumUtil.getDriver().findElement(By.xpath("//div[2]/div/div/a[2]")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Популярний")).click();
        seleniumUtil.getDriver().findElement(By.id("reg_racer_btn")).click();
        try {
            // Павло Мурзенко relates to another team, so team lead "team1" cannot register this racer
            new Select(seleniumUtil.getDriver().findElement(By.id("reg_racer_id"))).selectByVisibleText("Павло Мурзенко");
            seleniumUtil.getDriver().findElement(By.id("reg_racer")).click();
        } catch (NoSuchElementException e) {
            System.out.println("It's ok, this element mustn't be.");
        }
    }

    @After
    public void tearDown() throws Exception {
        seleniumUtil.quit();
    }
}

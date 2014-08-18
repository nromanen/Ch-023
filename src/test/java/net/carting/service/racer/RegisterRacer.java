package net.carting.service.racer;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;

import net.carting.service.Util.Locale;
import net.carting.service.Util.SeleniumUtil;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class RegisterRacer {
    private SeleniumUtil seleniumUtil;

    @Before
    public void setUp() throws Exception {
        seleniumUtil = new SeleniumUtil("team1", "1234", Locale.Eng);
    }

    @Test
    public void testRegisterRacer() throws Exception {
        seleniumUtil.login();
        seleniumUtil.getDriver().findElement(By.xpath("//div[2]/div/div/a[2]")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Популярний")).click();
        seleniumUtil.getDriver().findElement(By.id("reg_racer_btn")).click();
        new Select(seleniumUtil.getDriver().findElement(By.id("reg_racer_id"))).selectByVisibleText("Петро Іванов");
        seleniumUtil.getDriver().findElement(By.id("reg_racer")).click();
    }

    @After
    public void tearDown() throws Exception {
        seleniumUtil.quit();
    }
}
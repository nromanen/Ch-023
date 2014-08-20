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

public class UnregisterRacerFromOtherCommand {
    private SeleniumUtil seleniumUtil;

    @Before
    public void setUp() throws Exception {
        seleniumUtil = new SeleniumUtil("team1", "1234", Locale.Ua);
    }

    @Test
    public void testUnregisterRacerFromOtherCommand() throws Exception {
        seleniumUtil.login();
        seleniumUtil.getDriver().findElement(By.xpath("//div[2]/div/div/a[2]")).click();
        seleniumUtil.getDriver().findElement(By.cssSelector("b.caret")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Моя команда")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Чемпіонат Чернівецької області (весна 2014 року)")).click();
        seleniumUtil.getDriver().findElement(By.linkText("Популярний")).click();
        try {
            // unreg7 relates to another team, so team lead "team1" cannot unregister this racer
            WebElement webEl = seleniumUtil.getDriver().findElement(By.id("unreg7"));
            webEl.click();
            seleniumUtil.getDriver().findElement(By.id("unreg_racer")).click();
        } catch (NoSuchElementException e) {
            System.out.println("It's ok, this element mustn't be.");
        }
    }

    @After
    public void tearDown() throws Exception {
        seleniumUtil.quit();
    }
}

package net.carting.service.racer;

import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class RegisterRacerFromOtherCommand {
    private WebDriver driver;
    private String baseUrl;
    private boolean acceptNextAlert = true;
    private StringBuffer verificationErrors = new StringBuffer();

    @Before
    public void setUp() throws Exception {
        driver = new FirefoxDriver();
        baseUrl = "http://localhost:8080/Carting/";
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    @Test
    public void testRegisterRacerFromOtherCommand() throws Exception {
        driver.get("http://localhost:8080/Carting/logout");
        driver.get("http://localhost:8080/Carting/index");
        driver.findElement(By.linkText("Гість")).click();
        driver.findElement(By.linkText("Увійти")).click();
        driver.findElement(By.id("username")).clear();
        driver.findElement(By.id("username")).sendKeys("team1");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("1234");
        driver.findElement(By.xpath("//button[@type='submit']")).click();
        driver.findElement(By.xpath("//div[@id='left']/div/a[2]")).click();
        driver.findElement(By.linkText("Популярний")).click();
        driver.findElement(By.id("reg_racer_btn")).click();
        try {
            // Павло Мурзенко relates to another team, so team lead "team1" cannot register this racer
            new Select(driver.findElement(By.id("reg_racer_id"))).selectByVisibleText("Павло Мурзенко");
            driver.findElement(By.id("reg_racer")).click();
        } catch (NoSuchElementException e) {
            System.out.println("It's ok, this element mustn't be.");
        }
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
        String verificationErrorString = verificationErrors.toString();
        if (!"".equals(verificationErrorString)) {
            fail(verificationErrorString);
        }
    }

    private boolean isElementPresent(By by) {
        try {
            driver.findElement(by);
            return true;
        } catch (NoSuchElementException e) {
            return false;
        }
    }

    private boolean isAlertPresent() {
        try {
            driver.switchTo().alert();
            return true;
        } catch (NoAlertPresentException e) {
            return false;
        }
    }

    private String closeAlertAndGetItsText() {
        try {
            Alert alert = driver.switchTo().alert();
            String alertText = alert.getText();
            if (acceptNextAlert) {
                alert.accept();
            } else {
                alert.dismiss();
            }
            return alertText;
        } finally {
            acceptNextAlert = true;
        }
    }
}

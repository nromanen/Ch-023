package net.carting.service.Util;

import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.util.concurrent.TimeUnit;

/**
 * Carting
 * Created by manson on 8/12/14.
 */
public class SeleniumUtil {

    private WebDriver driver;
    private String baseUrl;
    private boolean acceptNextAlert = true;
    private StringBuffer verificationErrors = new StringBuffer();

    private String name;

    private String password;

    private Locale locale;

    public Locale getLocale() {
        return locale;
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public SeleniumUtil(String userName, String password, Locale locale) {
        setName(userName);
        setPassword(password);
        setLocale(locale);
        driver = new FirefoxDriver();
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    public void login() {
        driver.get("http://localhost:8080/Carting/logout" + getLocale());
        driver.get("http://localhost:8080/Carting/loginPage"+ getLocale());
        driver.findElement(By.id("username")).clear();
        driver.findElement(By.id("username")).sendKeys(getName());
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys(getPassword());
        driver.findElement(By.xpath("//button[@type='submit']")).click();
    }

    public WebDriver getDriver() {
        return driver;
    }

    public boolean isElementPresent(By by) {
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

    public void quit() {
        driver.quit();
    }

}

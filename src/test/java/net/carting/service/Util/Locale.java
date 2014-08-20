package net.carting.service.Util;

public enum Locale {

    Ru ("?lang=ru"),
    Ua ("?lang=ua"),
    Eng ("?lang=en");

    private String value;

    private Locale(String text) {
        this.value = text;
    }


    @Override
    public String toString() {
        return value;
    }
}
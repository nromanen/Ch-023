package net.carting.util;

import java.io.PrintWriter;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;

public class db2sql {

    public static void main(String[] args) {
        Properties props = new Properties();
        try {
            props.load(new FileInputStream(args[0]));
            //System.out.println(DataBaseDumper.dumpDB(props));
            PrintWriter writer = new PrintWriter("carting_dump.sql", "UTF-8");
            writer.println(DataBaseDumper.dumpDB(props));
            writer.close();
        } catch (IOException e) {
            System.err.println("Unable to open property file: "+args[0]+" exception: "+e);
        }

    }
}
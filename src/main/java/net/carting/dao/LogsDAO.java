package net.carting.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
public interface LogsDAO {

    List getAllLogs();

    List getLogsByDate(Timestamp date);

    List getLogsByPeriod(Timestamp start, Timestamp end);

}

package net.carting.dao;

import java.util.Date;
import java.util.List;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
public interface LogsDAO {

    List getAllLogs();

    List getLogsByDate(Date date);

    List getLogsByPeriod(Date start, Date end);

}

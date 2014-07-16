package net.carting.dao;

import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class RacerDAOImpl implements RacerDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<Racer> getAllRacers() {
		return sessionFactory.getCurrentSession().createQuery("from Racer")
				.list();
	}

	@Override
	public Racer getRacerById(int id) {
		return (Racer) sessionFactory.getCurrentSession().get(Racer.class, id);
	}

	@Override
	public void addRacer(Racer racer) {
		sessionFactory.getCurrentSession().save(racer);
	}

	@Override
	public void updateRacer(Racer racer) {
		sessionFactory.getCurrentSession().merge(racer);
	}

	@Override
	public void deleteRacer(Racer racer) {
		sessionFactory.getCurrentSession().delete(racer);
	}

	@Override
	public boolean isSetRacer(String firstName, String lastName, Date birthday) {
		String hql = "from Racer r where r.firstName=? and r.lastName=? and r.birthday=?";
		Query query = sessionFactory.getCurrentSession().createQuery(hql)
				.setString(0, firstName).setString(1, lastName)
				.setParameter(2, birthday);

		List result = query.list();
		if (result.size() > 0) {
			return true;
		}
		return false;
	}

	@Override
	public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
			int documentType) {
		String hql = "SELECT racer FROM Racer racer JOIN racer.documents document WHERE document.type = :documentType";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		query.setParameter("documentType", documentType);
		return query.list();
	}

}

package com.acorn5.booking;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import com.acorn5.booking.users.entity.Team;
import com.acorn5.booking.users.entity.Users;

public class JPAMain {
	public static void main(String[] args) {
		EntityManagerFactory emf =Persistence.createEntityManagerFactory("booking");
		
		EntityManager em = emf.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		tx.begin();
		
		try { 
			
			Team team = new Team();
			team.setName("teamA");
			em.persist(team);
			
			Users users = new Users();
			//users.setNum(5);
			users.setId("JPA");
			users.setTeam(team);
			//team.getUsers().add(users);
			
			em.persist(users);
			
			// 
			em.flush();
			em.clear();
			
			Users findUsers = em.find(Users.class, users.getNum());
			Team findTeam = findUsers.getTeam();

			findTeam.getName();
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
		} finally {
			em.close();
		}
		
		emf.close();
	}
}

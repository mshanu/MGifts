package com.breigns.vms

class Role {

	String authority
    String description;

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}

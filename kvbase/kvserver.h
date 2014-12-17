// Class definition for kvserver class
// A key-value server

#ifndef CLASS_KVSERVER_H
#define CLASS_KVSERVER_H

#include <string>
#include <vector>

class kv_server 
{
	public:
		kv_server();
		~kv_server();
		bool put(std::string key, std::vector<unsigned char>& value);
		bool get(std::string key, std::vector<unsigned char>& value);
	private:
		std::vector<std::pair<std::string, std::vector<unsigned char>>> data;	
};

#endif // CLASS_KVSERVER_H

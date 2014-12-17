#include "kvserver.h"

kv_server::kv_server()
{
	
}

kv_server::~kv_server()
{
	
}

bool kv_server::put(std::string key, std::vector<unsigned char>& value)
{
	data.push_back(make_pair(key, value));
	
	return true;
}

bool kv_server::get(std::string key, std::vector<unsigned char>& value)
{
	for(auto& it : data)
	{
		if(it.first == key)
		{
			value = it.second;
			return true;
		}
	}
	
	return false;
}

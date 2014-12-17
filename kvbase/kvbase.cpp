#include "kvserver.h"

#include <iostream>

void random_fill(std::vector<unsigned char>& a)
{
	for(unsigned int i=0; i<50; i++)
		a.push_back((unsigned char)rand()%256);	
}

int main(int argc, char** argv)
{
	kv_server* srv = new kv_server();
	
	std::string key1 = "key1guid_v100";
	std::vector<unsigned char> value1;
	random_fill(value1);
	
	std::string key2 = "key2gui_v100";
	std::vector<unsigned char> value2;
	random_fill(value2);
	
	srv->put(key1, value1);
	srv->put(key2, value2);
	
	std::vector<unsigned char> retval;
	bool ret = srv->get(key2, retval);
	
	if(ret)
	{
		std::cout << "Found a match for " << key1 << ":" << std::endl;
		for(unsigned int i=0; i<retval.size(); i++)
			std::cout << retval[i];
		std::cout << std::endl;
	}
	else
		std::cout << "Did not find a match." << std::endl;
	
	std::cout << "Ironically press Enter to Exit...";
	std::cin.get();
			
	return 0;
}

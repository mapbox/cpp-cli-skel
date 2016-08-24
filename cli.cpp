#include <hello_world.hpp>
#include <boost/program_options.hpp>

#include <iostream>
#include <cassert>

#define VERSION "v0.0.1\n"

using namespace boost::program_options;

int main(int argc, char** argv) {
  try {
    options_description desc("\nusage: cli <phrase>");

    desc.add_options()
    ("help,h", "show help")
    ("version,v", "show version number")
    ("phrase,p", value<std::string>(), "Input phrase");

    positional_options_description p;
    p.add("phrase", 1);
    variables_map vm;

    auto parser = command_line_parser(argc, argv).options(desc).positional(p);
    store(parser.run(), vm);

    if (vm.count("help")) {
      std::cout << desc;
    } else if (vm.count("version")) {
      std::cout << VERSION;
    } else {
      std::string phrase;
      if (vm.count("phrase")) {
        phrase = vm["phrase"].as<std::string>();
      } else {
        std::cout << "Error: you must pass in a phrase to be exclaimed." << "\n";
        return 1;
      }

      // use hello_world::exclaim
      std::string output(hello_world::exclaim(phrase));
      std::cout << output << "\n";

      return 0;
    }
  } catch (std::exception const& ex) {
    std::cout << "error: " << ex.what() << "\n";
    return -1;
  }
}
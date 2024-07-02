/*
CMOD (composition module)
Copyright (C) 2005  Sever Tipei (s-tipei@uiuc.edu)
Modified by Ming-ching Chiu 2013

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/
// all codes with the comment "multistaffs" are added by xiaoyi han
//----------------------------------------------------------------------------//
//
//  Piece.h
//
//----------------------------------------------------------------------------//


#ifndef PIECE_H
#define PIECE_H
#include "CMOD.h"

#include "Libraries.h"
#include "Note.h"
#include <stdlib.h>
#include <stdio.h>

//----------------------------------------------------------------------------//

struct PieceHelper {

  ///Lists contents of directory.
  static int getDirectoryList(string dir, vector<string> &files);

  ///Ensures a path has a backslash on the end.
  static string getFixedPath(string path);

  ///Determines the name of the project in the given directory.
  static string getProjectName(string path);

  ///Converts a seed string into a seed number.
  static int getSeedNumber(string seed);

  ///Creates the sound files directory if it does not exist.
  static void createSoundFilesDirectory(string path);

  ///Creates the score files directory if it does not exist.
  static void createScoreFilesDirectory(string path);

  ///Checks to see if a file exists.
  static bool doesFileExist(string path, string filename);

  ///Gets the next available sound file.
  static string getNextSoundFile(string path, string projectName);
};

//----------------------------------------------------------------------------//
class FileValue;
class Utilities;

class Piece {

  public:


  /**
  * Constructor
  **/
  Piece(string _workingPath, string _projectTitle);

  /**
  * Destructor
  **/
  ~Piece();

  /**
  * Prints information about the piece.
  **/
  void Print();

  ///Gets the next available sound file.
  string getNextSoundFile();

  //Modifies the Piece by writing to the DOMDocument. Returns vector of its children.
  // Experimental
  vector<DOMElement*> modifyPiece(DOMElement* eventElement);

  //Identifies function and modifies their numbers. Experimental
  void functionModifier(DOMElement* functionElement, int maxValue);

  //Calculates Aesthetic value for every event. Returns vector of events children.
  //Experimental
  vector<DOMElement*> calculateAesthetic(DOMElement* eventElement);

  //Calculates Shannon Entropy ratio based on sampled values
  double calculateEntropyRatio(vector<double> sampleData, string partitionMethod,
                                double min, double max);

  // Genetic Evolution Algorithm.
  void geneticOptimization(string fitnessFunction, double optimum);

  // Crossover and Mutation Function
  void crossoverMutation(DOMElement* parent1, DOMElement* parent2, DOMElement* child,
                         double mutationProb);

  // Experiment 2: Calculate M val for an event
  vector<DOMElement *> calcEventM(DOMElement* eventElement);

  // Exp 2: List

  private:

  string path;
  string projectName;
  string title;
  string fileFlags;
  string fileList;
  string pieceStartTime;
  string pieceDuration;

  Utilities* utilities;

  bool soundSynthesis;
  bool scorePrinting;
  bool grandStaff;
  int numberOfStaff;
  int numChannels;
  int sampleRate;
  int sampleSize;
  int numThreads;

};

//----------------------------------------------------------------------------//
#endif

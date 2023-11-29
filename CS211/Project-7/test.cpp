        virtual void attemptMoveTo(size_t& newR, size_t& newC, size_t hRow, size_t hCol) {
            //------------------------------------------------------------------------
            // TODO: write attemptMoveTo() for Hero 
            //      
            //      Hero's attempted move is determined by the nextMove data member 
            //      analyze nextMove to determine attempted new position for Hero
            //          'q' = up and left       'w' = up        'e' = up and right
            //          'a' = left              's' = stay      'd' = right
            //          'z' = down and left     'x' = down      'c' = down and right
            //       interpret ANY other input as 's' = stay
            //------------------------------------------------------------------------
            if (nextMove == 'q') {
                this->setRow(this->getRow() + 1); // up
                this->setCol(this->getCol() - 1); // left
            } else if (nextMove == 'a') {
                this->setCol(this->getCol() - 1); // left
            } else if (nextMove == 'z') {
                this->setRow(this->getRow() - 1); // down
                this->setCol(this->getCol() - 1); // left
            } else if (nextMove == 'w') {
                this->setRow(this->getRow() + 1); // up
            } else if (nextMove == 'x') {
                this->setRow(this->getRow() - 1); // down
            } else if (nextMove == 'e') {
                this->setRow(this->getRow() + 1); // up
                this->setCol(this->getCol() + 1); // right
            } else if (nextMove == 'd') {
                this->setCol(this->getCol() + 1); // right
            } else if (nextMove == 'c') {
                this->setRow(this->getRow() - 1); // down
                this->setCol(this->getCol() + 1); // right
            }
            newR = this->getRow(); // modify/remove this line
            newC = this->getCol(); // modify/remove this line
        }
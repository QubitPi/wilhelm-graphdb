#!/bin/bash
set -x
set -e

# Copyright Jiaqi Liu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export NEO4J_URI=neo4j://localhost:7687
export NEO4J_DATABASE=neo4j
export NEO4J_USERNAME=not_used
export NEO4J_PASSWORD=not_used

set +e
docker stop neo4j-loader
docker rm neo4j-loader
set -e

docker run \
    --publish=7474:7474 \
    --publish=7687:7687 \
    --env=NEO4J_AUTH=none \
    --env=NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    --name neo4j-loader \
    neo4j:5.24-enterprise &
# note that we do not explicitly wait for Neo4J because the raw-wiktextract-data.jsonl download below would compensate

rm -rf wilhelm-graphdb
git clone https://github.com/QubitPi/wilhelm-graphdb.git
cd wilhelm-graphdb
python3 -m virtualenv .venv
source .venv/bin/activate
pip3 install -r requirements.txt

wget https://kaikki.org/dictionary/raw-wiktextract-data.jsonl.gz
gzip -d raw-wiktextract-data.jsonl.gz
# wget https://kaikki.org/dictionary/raw-wiktextract-data.jsonl
python3 load-basic.py -i ./raw-wiktextract-data.jsonl
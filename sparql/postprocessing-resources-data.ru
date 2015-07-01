PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX void: <http://rdfs.org/ns/void#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX dgfr: <http://colin.maudry.com/ontologies/dgfr#>

#Store original media type for the few distributions that have one
with <urn:graph:postprocessing>
delete {?distribution dcat:byteSize ?someSize ;
			 dcat:mediaType ?oriMediaType .}
insert {?distribution dgfr:oriMediaType ?oriMediaType .}
where {
	?distribution a dcat:Distribution ;
						dcat:byteSize ?someSize ;			
						dcat:mediaType ?oriMediaType .
	};

#Copy distribution data over to postprocessing graph
ADD <urn:files:data> TO <urn:graph:postprocessing> ;

#Replace the value of dcat:mediaType from distribution data with the original one
with <urn:graph:postprocessing>
delete {?distribution dcat:mediaType ?newMediaType ;
			 dgfr:oriMediaType ?oriMediaType .}
insert {?distribution dcat:mediaType ?oriMediaType .}
where {
	?distribution a dcat:Distribution ;
						dgfr:oriMediaType ?oriMediaType ;
						dcat:mediaType ?newMediaType .
	};
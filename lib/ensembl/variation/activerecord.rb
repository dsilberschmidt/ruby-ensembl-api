#
# = ensembl/variation/activerecord.rb - ActiveRecord mappings to Ensembl Variation
#
# Copyright::   Copyright (C) 2008 Francesco Strozzi <francesco.strozzi@gmail.com>
# License::     The Ruby License
#
# @author Francesco Strozzi

nil
module Ensembl
  # The Ensembl::Variation module covers the variation databases from
  # ensembldb.ensembl.org.
  module Variation
    # The Allele class describes a single allele of a variation. In addition to
    # the nucleotide(s) (or absence of) that representing the allele frequency
    # and population information may be present.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    #
    # @example
    #  allele = Allele.find(1)
    #  puts allele.to_yaml
    class Allele < DBConnection
      set_primary_key 'allele_id'
      belongs_to :sample
      belongs_to :variation
      belongs_to :population
    end

    # The AlleleGroup class represents a grouping of alleles that have tight 
    # linkage and are usually present together. This is commonly known as a 
    # Haplotype or Haplotype Block. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    #
    # @example
    #  allele_group = AlleleGroup.find(1)
    #  puts allele_group.to_yaml
    class AlleleGroup < DBConnection
      set_primary_key 'allele_group_id'
      belongs_to :variation_group
      belongs_to :source
      belongs_to :sample
      belongs_to :allele_group_allele
    end
    
    # The AlleleGroupAllele class represents a connection class between Allele and AlleleGroup. 
    # Should not be used directly.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.    
    class AlleleGroupAllele < DBConnection
      belongs_to :variation
      belongs_to :allele_group
    end
    
    # The Sample class gives information about the biological samples stored in the database. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class Sample < DBConnection
      set_primary_key "sample_id"
      has_one :individual
      has_one :sample_synonym
      has_many :individual_genotype_multiple_bp
      has_many :compressed_genotype_single_bp
      has_many :read_coverage
      has_one :population
      has_many :tagged_variation_features
    end

    # The IndividualPopulation class is used to connect Individual and Population classes. 
    # Should not be used directly.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.    
    class IndividualPopulation < DBConnection
      belongs_to :individual
      belongs_to :population
    end
    
    # The Individual class gives information on the single individuals used 
    # to retrieve one or more biological samples.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class Individual < DBConnection
      belongs_to :sample
      # FIXME
    end
    
    class IndividualGenotypeMultipleBp < DBConnection
      belongs_to :sample
      belongs_to :variation
    end
    
    class CompressedGenotypeSingleBp < DBConnection
      belongs_to :sample
    end  
    
    class ReadCoverage < DBConnection
      belongs_to :sample
    end
    
    class Population < DBConnection
      belongs_to :sample
    end
    
    class PopulationStructure < DBConnection
      # FIXME
    end
    
    # The PopulationGenotype class gives information about alleles and allele 
    # frequencies for a SNP observed within a population or a group of samples. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class PopulationGenotype < DBConnection
      set_primary_key "population_genotype_id"
      belongs_to :variation
      belongs_to :population
    end
    
    # The SampleSynonym class represents information about alternative names 
    # for sample entries. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class SampleSynonym < DBConnection
      set_primary_key "sample_synonym_id"
      belongs_to :source
      belongs_to :sample
      belongs_to :population
    end
    
    # The Source class gives information on the different databases and SNP 
    # panels used to retrieve the data
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class Source < DBConnection
      set_primary_key "source_id"
      has_many :sample_synonyms
      has_many :allele_groups
      has_many :variations
      has_many :variation_groups
      has_many :httags
      has_many :variation_synonyms
    end
    
    # The VariationSynonym class gives information on alterative names used 
    # for Variation entries. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class VariationSynonym < DBConnection
      set_primary_key "variation_synonym_id"
      belongs_to :variation
      belongs_to :source
    end
        
    # The VariationGroup class represents a group of variations (SNPs) that are 
    # linked and present toghether. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class VariationGroup < DBConnection
      set_primary_key "variation_group_id"
      belongs_to :source
      has_one :variation_group_variation
      has_one :httag
      has_one :variation_group_feature
      has_one :allele_group
    end
    
    # The VariationGroupVariation class is a connection class. 
    # Should not be used directly.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class VariationGroupVariation < DBConnection
      belongs_to :variation
      belongs_to :variation_group
    end
    
    # The VariationGroupFeature class gives information on the genomic position 
    # of each VariationGroup.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.    
    class VariationGroupFeature < DBConnection
      set_primary_key "variation_group_feature_id"
      belongs_to :variation_group
    end
    
    # The FlankingSequence class gives information about the genomic coordinates 
    # of the flanking sequences, for a single VariationFeature. 
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class FlankingSequence < DBConnection
      belongs_to :variation
    end
    
    # The TaggedVariationFeature class is a connection class. 
    # Should not be used directly.
    #
    # This class uses ActiveRecord to access data in the Ensembl database.
    # See the general documentation of the Ensembl module for
    # more information on what this means and what methods are available.
    class TaggedVariationFeature < DBConnection
      belongs_to :variation_feature
      belongs_to :sample
    end
    
    class Httag < DBConnection
      set_primary_key "httag_id"
      belongs_to :variation_group
      belongs_to :source
    end
  end
end

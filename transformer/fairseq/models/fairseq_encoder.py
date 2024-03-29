# Copyright (c) 2017-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the license found in the LICENSE file in
# the root directory of this source tree. An additional grant of patent rights
# can be found in the PATENTS file in the same directory.

import torch.nn as nn


class FairseqEncoder(nn.Module):
    """Base class for encoders."""

    def __init__(self):
        super().__init__()

    def forward(self, src_tokens, src_lengths):
        raise NotImplementedError

    def reorder_encoder_out(self, encoder_out, new_order):
        """Reorder encoder output according to new_order."""
        raise NotImplementedError


    def upgrade_state_dict(self, state_dict):
        return state_dict
